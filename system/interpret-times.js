#!/usr/bin/env node

const { exec }=require('child_process');
const { writeFileSync, appendFileSync } = require('fs');

// Called at 12:05am every day

(async ()=>{
    const hyphenatedInstitutionName='riverdale-country-school'; // TODO:
    const env='prod';
    const schedule=await fetch(`${env==='dev' ? 'http://localhost:3000' : 'https://buseroo.com'}/api/institution/public/kiosk/schedule/today?institution=${hyphenatedInstitutionName}`).then(res=>res.json());
    console.log(`Today's schedule for ${new Date().toLocaleString()}: ${JSON.stringify(schedule)}`);

    // Set actions with `at`
    let log='';
    schedule.forEach(({action, time})=>{
        let toLog=`Scheduled to turn ${action} at ${time}`;
        console.log(toLog);
        log+=toLog+'\n';
        exec(`at -f 'BASE_INSERTED_HERE_BY_INSTALL_SH/gpio/exec/turn_${action}_monitor' ${time}`, (error, stdout, stderr)=>{
            if (error)
                console.error(`Error from exec: ${error}`);
            if (stderr)
                console.error(`Stderr from exec: ${error}`);
            if (stdout)
                console.log(`Stdout from exec: ${stdout}`);
        });
    });

    // Log
    appendFileSync('BASE_INSERTED_HERE_BY_INSTALL_SH/schedule-log.txt', `___${`${new Date().getMonth()+1}.${new Date().getDate()}.${new Date().getFullYear()}`}___\n${log}\n`);
})();
