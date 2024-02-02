const mysql = require("mysql");

    const db = mysql.createConnection({
        host:"localhost",
        user:"root",
        password:"",
        database:'gestionnaire'
    })

   db.connect((err)=>{
    if(err){
        console.log("echec de connection a mysql")
    }else{
        console.log("connecter a mysql avec succes!!");
    }
   })


module.exports = db;