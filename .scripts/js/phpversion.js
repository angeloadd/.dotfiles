#!/usr/bin/env node

const PHP_VERSIONS = [
    '8.2',
    '8.3'
]

const execCommand = (command) => {
    const {exec} = require('child_process')

    const childProcess = exec(command)

    return new Promise((resolve, reject) => {
        let stdout = ''

        childProcess.stdout.on('data', (data) => stdout += data)

        childProcess.on('error', function (error) {
            reject({code: 1, error: error})
        })

        childProcess.on('close', function (code) {
            if (code > 0) {
                reject({code: code, error: `Command[${command}] failed with code ${code}`})
            } else {
                resolve({code: code, data: stdout})
            }
        })
    })
}

const processScript = async () => {
    try {
        const errorMessage = 'You must specify a valid php version. Supported version are: ' + PHP_VERSIONS.join(', ')

        if (process.argv.length > 2) {
            const newPhpVersion = process.argv.at(2)
            if (PHP_VERSIONS.includes(newPhpVersion)) {

                let execPhpVersion = await execCommand('php -v | sed -n 1p')
                const threeDigitPhpVersion = execPhpVersion.data.match(/\d+.\d+.\d+/)[0]
                let phpVersion
                if (threeDigitPhpVersion) {
                    phpVersion = threeDigitPhpVersion.split('.').filter((ek, i) => i !== 2).join('.')
                } else {
                    phpVersion = newPhpVersion
                }

                console.info(`current php version: php@${phpVersion}`)

                await execCommand(`brew unlink php@${phpVersion}`)
                console.info(`...unlinking php v${phpVersion}`)

                await execCommand(`brew link php@${newPhpVersion}`)
                console.info(`...linking php v${newPhpVersion}`)

                await execCommand('brew services restart php')
                console.info('Service restarted successfully')

                return
            }

            console.error(errorMessage)
            process.exit(1)
        }
        console.error(errorMessage)
        process.exit(1)

    } catch (error) {
        console.error(error)
        process.exit(error && error.code || 1)
    }
}

processScript()
