const figlet=require('figlet');
const gradient = require('gradient-string');

async function title() { //resolves once title complete
    return new Promise((resolve, reject)=>{
        figlet('J Kiosk', (err, data)=>{
            console.log(gradient.pastel.multiline(data))
            resolve();
        });
    });
}

module.exports=title;