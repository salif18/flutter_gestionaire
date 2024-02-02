const db = require("../db/mysqldb");
const Ventes = require("../models/ventes");

exports.createVente = async (req, res) => {
  try {
    const { id, nom, categories, prixAchat, prixVente, stocks, qty, timestamps } = req.body;

    const sql = 'INSERT INTO vente (id, nom, categories, prixAchat, prixVente, stocks, qty, timestamps) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';
    const values = [id, nom, categories, prixAchat, prixVente, stocks, qty, timestamps];

    const results = await new Promise((resolve, reject) => {
      db.query(sql, values, (err, results) => {
        if (err) {
          console.error('Erreur lors de l\'insertion de la vente :', err);
          reject(err);
        } else {
          console.log('Vente effectuée avec succès !!');
          resolve(results);
        }
      });
    });

    res.status(200).json({ message: 'Vente effectuée avec succès !!', results });
  } catch (error) {
    console.error('Erreur lors de la création de la vente :', error);
    res.status(500).json({ error: 'Erreur serveur lors de la vente' });
  }
};


exports.getVentes = (req,res) =>{
    const sql = 'SELECT * FROM vente ORDER BY timestamps DESC';
    db.query(sql,(err,results)=>{
        if(err){
            res.status(500).json({err})
        }else{
            res.status(200).json(results)
        }
    })
}

exports.deleteVente = (req,res) => {
  const {id} = req.params
  const sql =`DELETE FROM vente WHERE id = ?`
  db.query(sql,[id] ,(err)=>{
     if(err){
      res.status(500).json({err})
     }else{
      res.status(200).json({message:'La vente a été annulée avec succès !!'})
     }
  })
}


exports.statsVentes = async (req, res) => {
  try {
    const sql =`
      SELECT
        YEAR(timestamps) AS annee,
        MONTH(timestamps) AS mois,
        COUNT(*) AS nombre_ventes,
        SUM(prixVente * qty) AS total_ventes
        FROM vente
        GROUP BY annee, mois
        ORDER BY annee, mois;
    `;
    
    const results = await new Promise((resolve,reject)=>{
        db.query(sql,(err,results)=>{
          if(err){
            reject(err)
          }else{
            resolve(results)
          }
        })
    })
    return res.status(200).json(results);
  } catch (err) {
    res.status(500).json({ error: 'Une erreur s\'est produite lors de la récupération des statistiques de vente.' });
  }
}


exports.PlusVendus = async(req,res) => {
  const sql = `SELECT nom,categories, 
                   SUM(qty) as total_vendu 
                   FROM vente 
                   GROUP BY nom ,categories
                   ORDER BY total_vendu DESC  `
  try{
    const results = await new Promise((resolve,reject) => {
      db.query(sql,(err,results)=>{
        if(err){
          reject(err)
        }else{
          resolve(results)
        }
      })
    })
    return res.status(200).json(results)
  }catch(err){
    return res.status(500).json({error:err.message})
  }
}