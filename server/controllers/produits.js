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

  //Version en laravel
//   <?php

// namespace App\Http\Controllers;

// use App\Models\Produit;
// use Illuminate\Http\Request;
// use Illuminate\Support\Facades\Validator;

// class ProduitController extends Controller
// {
//     // Ajouter un nouveau produit
//     public function insertProduits(Request $request)
//     {
//         // Récupérer les données de la requête
//         $data = $request->only(['nom', 'categories', 'prixAchat', 'prixVente', 'stocks', 'dateAchat']);

//         try {
//             // Valider les données de la requête
//             $validator = Validator::make($data, [
//                 'nom' => 'required|string',
//                 'categories' => 'required|string',
//                 'prixAchat' => 'required|numeric',
//                 'prixVente' => 'required|numeric',
//                 'stocks' => 'required|integer',
//                 'dateAchat' => 'required|date',
//             ]);

//             // Si la validation échoue, renvoyer une réponse avec les erreurs
//             if ($validator->fails()) {
//                 return response()->json(['errors' => $validator->errors()], 400);
//             }

//             // Créer un nouveau produit avec les données de la requête
//             $produit = Produit::create($data);

//             // Retourner une réponse JSON indiquant que le produit a été ajouté avec succès
//             return response()->json(['message' => 'Produit ajouté avec succès !!'], 201);
//         } catch (\Exception $err) {
//             // En cas d'erreur, retourner une réponse avec le message d'erreur
//             return response()->json(['error' => $err->getMessage()], 500);
//         }
//     }

//     // Obtenir tous les produits
//     public function getAllProduits()
//     {
//         try {
//             // Récupérer tous les produits ordonnés par dateAchat DESC
//             $produits = Produit::orderBy('dateAchat', 'DESC')->get();

//             // Retourner une réponse JSON contenant tous les produits
//             return response()->json($produits, 200);
//         } catch (\Exception $err) {
//             // En cas d'erreur, retourner une réponse avec le message d'erreur
//             return response()->json(['error' => $err->getMessage()], 500);
//         }
//     }

//     // Obtenir un seul produit par son ID
//     public function getOneProduit($id)
//     {
//         try {
//             // Rechercher le produit par son ID
//             $produit = Produit::findOrFail($id);

//             // Retourner une réponse JSON contenant le produit
//             return response()->json($produit, 200);
//         } catch (\Exception $err) {
//             // En cas d'erreur, retourner une réponse avec le message d'erreur
//             return response()->json(['error' => $err->getMessage()], 500);
//         }
//     }

//     // Mettre à jour un produit
//     public function updateProduit(Request $request, $id)
//     {
//         // Récupérer les données de la requête
//         $data = $request->only(['nom', 'categories', 'prixAchat', 'prixVente', 'stocks']);

//         try {
//             // Valider les données de la requête
//             $validator = Validator::make($data, [
//                 'nom' => 'required|string',
//                 'categories' => 'required|string',
//                 'prixAchat' => 'required|numeric',
//                 'prixVente' => 'required|numeric',
//                 'stocks' => 'required|integer',
//             ]);

//             // Si la validation échoue, renvoyer une réponse avec les erreurs
//             if ($validator->fails()) {
//                 return response()->json(['errors' => $validator->errors()], 400);
//             }

//             // Mettre à jour le produit
//             Produit::where('id', $id)->update($data);

//             // Retourner une réponse JSON indiquant que le produit a été modifié avec succès
//             return response()->json(['message' => 'Produit modifié avec succès !!'], 200);
//         } catch (\Exception $err) {
//             // En cas d'erreur, retourner une réponse avec le message d'erreur
//             return response()->json(['error' => $err->getMessage()], 500);
//         }
//     }

//     // Mettre à jour un champ d'un produit
//     public function updateField(Request $request, $id)
//     {
//         // Valider les données de la requête
//         $validator = Validator::make($request->all(), [
//             'stocks' => 'required|integer',
//         ]);

//         // Si la validation échoue, renvoyer une réponse avec les erreurs
//         if ($validator->fails()) {
//             return response()->json(['errors' => $validator->errors()], 400);
//         }

//         try {
//             // Mettre à jour le champ stocks du produit
//             Produit::where('id', $id)->update(['stocks' => $request->stocks]);

//             // Retourner une réponse JSON indiquant que le champ a été mis à jour avec succès
//             return response()->json(['message' => 'Champ mis à jour avec succès !!'], 200);
//         } catch (\Exception $err) {
//             // En cas d'erreur, retourner une réponse avec le message d'erreur
//             return response()->json(['error' => $err->getMessage()], 500);
//         }
//     }

//     // Supprimer un produit par son ID
//     public function deleteProduit($id)
//     {
//         try {
//             // Supprimer le produit par son ID
//             Produit::findOrFail($id)->delete();

//             // Retourner une réponse JSON indiquant que le produit a été supprimé avec succès
//             return response()->json(['message' => 'Produit supprimé avec succès !!'], 200);
//         } catch (\Exception $err) {
//             // En cas d'erreur, retourner une réponse avec le message d'erreur
//             return response()->json(['error' => $err->getMessage()], 500);
//         }
//     }
// }
