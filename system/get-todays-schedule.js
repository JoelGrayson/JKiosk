#!/usr/bin/env node

// ABOUT: Called at 12:05am every day

const { exec }=require('child_process');
const { appendFileSync, writeFileSync } = require('fs');

(async ()=>{
    function hyphenateName(name) {
        name=name.trim().toLowerCase();
        for (const separator of ['+', '-', '%20', ' '])
            name=name.replaceAll(separator, '-');
        return name;
    }
    const hyphenatedInstitutionName=hyphenateName('INSTITUTION_INSERTED_HERE_BY_INSTALL_SH');

    const env='prod';
    const schedule=await fetch(`${env==='dev' ? 'http://localhost:3000' : 'https://buseroo.com'}/api/institution/public/kiosk/schedule/today?institution=${hyphenatedInstitutionName}`).then(res=>res.json());
    console.log(`Today's schedule for ${new Date().toLocaleString()}: ${JSON.stringify(schedule)}`);
    const errHandler=(error, stdout, stderr)=>{
        if (error!=null && !error)
            console.error(`Error from exec: ${error}`);
        if (stderr!=null && !stderr)
            console.error(`Stderr from exec: ${stderr}`);
        if (stdout)
            console.log(`Stdout from exec: ${stdout}`);
    };

    // Set actions with `at`
    let log='';
    schedule.forEach(({action, time})=>{
        let toLog=`Scheduled to turn ${action} at ${time}`;
        console.log(toLog);
        log+=toLog+'\n';
        exec(`at -f 'BASE_INSERTED_HERE_BY_INSTALL_SH/gpio/exec/turn-${action}-monitor' ${time}`, errHandler);
    });
    writeFileSync('BASE_INSERTED_HERE_BY_INSTALL_SH/system/todays-schedule.json', JSON.stringify(schedule));
    
    // Button LED On-Off so light not on at night (still works at night)
    exec(`at -f 'BASE_INSERTED_HERE_BY_INSTALL_SH/gpio/exec/button-led/turn-on' 08:00`, errHandler);
    exec(`at -f 'BASE_INSERTED_HERE_BY_INSTALL_SH/gpio/exec/button-led/turn-off' 19:00`, errHandler);

    // Log
    appendFileSync('BASE_INSERTED_HERE_BY_INSTALL_SH/logs/daily-schedules.log', `___${`${new Date().getMonth()+1}.${new Date().getDate()}.${new Date().getFullYear()}`}___\n${log}\n`);
})();
