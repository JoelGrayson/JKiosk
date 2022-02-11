const { exec }=require('child_process');

function handleExec(callback) { //higher-level function
    return (error, stdout, stderr)=>{
        if (error) {
            console.log('An error occurred: ', error);
        }
        if (stderr) {
            console.log('A stderr occurred: ', stderr);
        }
        if (!error && !stderr) {
            callback(stdout);
        }
    }
}

let printStdout=handleExec(stdout=>console.log(stdout)); //handles stdout by printing

function enable() {
    exec('sudo systemctl enable kiosk.service', printStdout);
}

function disable() {
    exec('sudo systemctl enable kiosk.service', printStdout);
}

function start() {
    exec('sudo systemctl start kiosk.service', printStdout);
}

function stop() {
    exec('sudo systemctl stop kiosk.service', printStdout);
}

function status() {
    exec('sudo systemctl status kiosk.service', printStdout);
}

module.exports={ enable, disable, start, stop, status };