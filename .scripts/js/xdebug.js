#!/usr/bin/env node

const XDEBUG_CONTENT = `[Xdebug]
zend_extension="xdebug.so"
xdebug.mode="debug"`

const execCommand = (command) => {
    const {exec} = require('child_process')

    const childProcess = exec(command)

    return new Promise((resolve, reject) => {
        let stdout = ''

        childProcess.stdout.on('data', (data) => stdout += data)

        childProcess.on('error', function(error) {
            reject({code: 1, error: error})
        })

        childProcess.on('close', function(code) {
            if (code > 0) {
                reject({code: code, error: 'Command failed with code ' + code})
            } else {
                resolve({code: code, data: stdout})
            }
        })
    })
}

const getIniDir = async () => {
    try {
        const phpini = await execCommand('php --ini | grep "Scan for additional .ini files in: "')

        return phpini.data.split(' ')
                     .at(-1)
                     .replace('\n', '')
    } catch (error) {
        console.error(error)
        process.exit(error && error.code || 1)
    }
}

const checkXdebug = async (iniDir) => {
    try {
        const grep = await execCommand(`ls -a ${iniDir} | grep "xdebug"`)
        return {hasIni: grep.data}
    } catch (error) {
        return {hasNotIni: error.error}
    }
}

// enable xdebug
const enableXdebug = async (iniDir, xdebugIni) => {
    try {
        if ('hasNotIni' in xdebugIni) {
            await execCommand(`touch ${iniDir}/xdebug.ini`)
        }

        await execCommand(`echo '${XDEBUG_CONTENT}' > ${iniDir}/xdebug.ini`)

        console.log('xdebug enabled')
    } catch (error) {
        console.log(error)
        console.log('enabling xdebug failed')
        process.exit(error && error.code || 1)
    }
}

// disable xdebug
const disableXdebug = async (iniDir, xdebugIni) => {
    try {
        if ('hasIni' in xdebugIni) {
            await execCommand(`rm ${iniDir}/xdebug.ini`)
        }

        console.log('xdebug disabled')
    } catch (error) {
        console.log(error)
        console.log('disabling xdebug failed')
        process.exit(error && error.code || 1)
    }
}

const processScript = async () => {
    try {
        const iniDir = await getIniDir()
        const xdebugIni = await checkXdebug(iniDir)

        if (process.argv.length > 2) {
            if (process.argv.at(2) === 'off') {
                console.log('...disabling xdebug')
                disableXdebug(iniDir, xdebugIni)
            } else if (process.argv.at(2) === 'on') {
                console.log('...enabling xdebug')
                enableXdebug(iniDir, xdebugIni)
            }
        } else {
            console.log('...enabling xdebug')
            enableXdebug(iniDir, xdebugIni)
        }
    } catch (error) {
        console.log(error)
        process.exit(error && error.code || 1)
    }

}

processScript()
