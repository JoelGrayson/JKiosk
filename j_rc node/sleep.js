async function sleep(ms=2000) {
    return new Promise((resolve, reject)=>{
        setTimeout(resolve, ms)
    })
}

module.exports=sleep;