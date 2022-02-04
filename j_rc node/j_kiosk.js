const chalk=require('chalk');
const inquirer = require('inquirer');
const chalkAnimation=require('chalk-animation');
const sleep=require('./sleep');
const gradient = require('gradient-string');

//Scenes
const title=require('./title');
const { enable, disable, start } = require('./commands.js');

// Main
async function main() {
    await title();
    console.log(gradient.pastel('Find a bus to anywhere')) //description

    let response=await inquirer.prompt({
        name: 'action',
        type: 'list',
        message: 'Choose an action',
        choices: [
            'enable',
            'disable',
            'start'
        ]
    })
    switch (response.action) {
        case 'enable':
            console.log(chalk.green('Enabling Kiosk'))
            console.log('Type `sudo reboot` for changes to take place.')
            enable();
            break;
        case 'disable':
            console.log(chalk.green('Disabling'))
            console.log('Type `sudo reboot` for changes to take place.')
            disable();
            break;
        case 'start':
            console.log(chalk.green('Starting'))
            start();
            break;
        default:
            console.log(chalk.red('Error: Unknown response:', response))
    }
}

main();

// Scenes
