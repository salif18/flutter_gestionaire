const db = require('../db/mysqldb');

const ProduitsModel = require('../models/products');

//enregistrer les produits
exports.insertProducts =async(req, res)=>{
    try {
        const { nom, categories, prixAchat, prixVente, stocks, dateAchat } = req.body;
        const produits = new ProduitsModel( nom, categories, prixAchat, prixVente, stocks, dateAchat );
    
        const results = await new Promise((resolve, reject) =>{
        db.query(`INSERT INTO produits set ?`, [produits],(err,results)=>{
            if(err){
                reject(err)
            }else{
                resolve(results)
            }
        });
      })
        return res.status(201).json({message:'Produit a été ajouté avec succès !!'});
      } catch (err) {
        return res.status(500).json({ error: err.message });
      }
}

//recuperer les produits
exports.getAllProduits = async (req, res) => {
    try {
      const results = await new Promise((resolve, reject) => {
        db.query(`SELECT * FROM produits ORDER BY dateAchat DESC`, (err, results) => {
          if (err) {
            reject(err);
          } else {
            resolve(results);
          }
        });
      });
      return res.status(200).json(results);
      
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  };

  //recuperer un seul produits
  exports.getOneProduit = async (req, res) => {
    try {
      const { id } = req.params;
  
      const results = await new Promise((resolve, reject) => {
        db.query(`SELECT*FROM produits WHERE id = ?`, [id], (err, results) => {
          if (err) {
            reject(err);
          } else {
            resolve(results);
          }
        });
      });
      return res.status(200).json(results);
    } catch (err) {
      return res.status(500).json({ error: err.message });
    }
  };
  
  //modifier produit
  exports.updateProduit = async (req, res) => {
      const { id } = req.params;
      const { nom, categories, prixAchat, prixVente, stocks } = req.body;
  
      const sql = `UPDATE produits 
                  SET nom = ?, categories = ?, prixAchat = ?, prixVente = ?, stocks = ? 
                  WHERE id = ?`;
  
      const newValue = [ nom, categories, prixAchat, prixVente, stocks, id ];
    try {
      const results = await new Promise((resolve, reject) => {
        db.query(sql, newValue, (err, results) => {
          if (err) {
            console.error(err)
            reject(err);
          } else {
            resolve(results);
          }
        });
      });
      return res.status(201).json({message:'Produit a été modifié avec succès !!'});
    } catch (err) {
      return res.status(500).json({ error: err.message });
    }
  };
  
  //modifier un champs
  exports.updatField = async (req, res) => {
    try {
      const { stocks } = req.body;
      const { id } = req.params;
      console.log(stocks);
      const results = await new Promise((resolve,reject)=>{
      db.query(
        `UPDATE produits set stocks = ? WHERE id = ?`,[stocks,id],(err,results)=>{
          if(err){
              reject(err)
          }else{
              resolve(results)
          }
        });
      })
      return res.status(201).json(results);
    } catch (err) {
      return res.status(500).json({ error: err.message });
    }
  };
  
  //supprimer un produit
  exports.deleteproduit = async (req, res) => {
    try {
      const { id } = req.params;
      const results = await new Promise((resolve,reject)=>{
          db.query(`DELETE FROM produits WHERE id = ?`, [id],(err,results)=>{
              if(err){
                  reject(err)
              }else{
                  resolve(results)
              }
          })
      }) 
      return res.status(200).json({message:'Le produit a été supprimé avec succès !!'});
    } catch (err) {
      return res.status(500).json({ error: err.message });
    }
  };