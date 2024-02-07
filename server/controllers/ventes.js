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
  console.log(id)
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

//version en laravel
// <?php

// namespace App\Http\Controllers;

// use App\Models\Vente;
// use Illuminate\Http\Request;
// use Illuminate\Support\Facades\DB;
// use Illuminate\Support\Facades\Validator;

// class VenteController extends Controller
// {
//     // Créer une nouvelle vente
//     public function createVente(Request $request)
//     {
//         try {
//             // Récupérer les données de la requête
//             $data = $request->only(['id', 'nom', 'categories', 'prixAchat', 'prixVente', 'stocks', 'qty', 'timestamps']);

//             // Valider les données de la requête
//             $validator = Validator::make($data, [
//                 'id' => ['required'],
//                 'nom' => ['required'],
//                 'categories' => ['required'],
//                 'prixAchat' => ['required', 'numeric'],
//                 'prixVente' => ['required', 'numeric'],
//                 'stocks' => ['required', 'numeric'],
//                 'qty' => ['required', 'numeric'],
//                 'timestamps' => ['required', 'date'],
//             ]);

//             // Si la validation échoue, renvoyer un message d'erreur
//             if ($validator->fails()) {
//                 return response()->json([
//                     'status' => false,
//                     'message' => 'Veuillez remplir tous les champs correctement',
//                     'errors' => $validator->errors()
//                 ], 400);
//             }

//             // Créer la vente
//             $vente = Vente::create($data);

//             // Retourner une réponse avec la vente créée
//             return response()->json([
//                 'status' => true,
//                 'message' => 'Vente effectuée avec succès !!',
//                 'vente' => $vente
//             ], 200);
//         } catch (\Exception $error) {
//             // En cas d'erreur, renvoyer un message d'erreur avec le code 500
//             return response()->json([
//                 'status' => false,
//                 'message' => 'Une erreur est survenue lors de la création de la vente.',
//                 'error' => $error->getMessage()
//             ], 500);
//         }
//     }

//     // Récupérer toutes les ventes
//     public function getVentes()
//     {
//         try {
//             // Récupérer toutes les ventes dans l'ordre décroissant de leur date de création
//             $ventes = Vente::orderByDesc('timestamps')->get();

//             // Retourner les ventes avec un statut de réussite
//             return response()->json([
//                 'status' => true,
//                 'ventes' => $ventes
//             ], 200);
//         } catch (\Exception $error) {
//             // En cas d'erreur, retourner un message d'erreur avec les détails de l'erreur
//             return response()->json([
//                 'status' => false,
//                 'message' => 'Une erreur est survenue lors de la récupération des ventes.',
//                 'error' => $error->getMessage()
//             ], 500);
//         }
//     }

//     // Supprimer une vente par son ID
//     public function deleteVente($id)
//     {
//         try {
//             // Supprimer la vente par son ID directement
//             Vente::destroy($id);

//             return response()->json([
//                 'status' => true,
//                 'message' => 'Vente supprimée avec succès !!',
//             ], 200);
//         } catch (\Exception $error) {
//             // En cas d'erreur, retourner un message d'erreur avec les détails de l'erreur
//             return response()->json([
//                 'status' => false,
//                 'message' => 'Une erreur est survenue lors de la suppression de la vente.',
//                 'error' => $error->getMessage()
//             ], 500);
//         }
//     }

//     // Récupérer les statistiques de vente
//     public function statsVentes()
//     {
//         try {
//             // Récupérer les statistiques de vente (total des ventes par année et mois)
//             $stats = Vente::select(
//                 DB::raw('YEAR(timestamps) as annee'),
//                 DB::raw('MONTH(timestamps) as mois'),
//                 DB::raw('COUNT(*) as nombre_ventes'),
//                 DB::raw('SUM(prixVente * qty) as total_ventes')
//             )->groupBy('annee', 'mois')
//                 ->orderBy('annee')
//                 ->orderBy('mois')
//                 ->get();

//             // Retourner les statistiques avec un statut de réussite
//             return response()->json([
//                 'status' => true,
//                 'stats' => $stats
//             ], 200);
//         } catch (\Exception $error) {
//             // En cas d'erreur, retourner un message d'erreur avec les détails de l'erreur
//             return response()->json([
//                 'status' => false,
//                 'message' => 'Une erreur est survenue lors de la récupération des statistiques de vente.',
//                 'error' => $error->getMessage()
//             ], 500);
//         }
//     }

//     // Récupérer les produits les plus vendus
//     public function plusVendus()
//     {
//         try {
//             // Récupérer les produits les plus vendus
//             $plusVendus = Vente::select('nom', 'categories', DB::raw('SUM(qty) as total_vendu'))
//                 ->groupBy('nom', 'categories')
//                 ->orderByDesc('total_vendu')
//                 ->get();

//             // Retourner les produits les plus vendus avec un statut de réussite
//             return response()->json([
//                 'status' => true,
//                 'plus_vendus' => $plusVendus
//             ], 200);
//         } catch (\Exception $error) {
//             // En cas d'erreur, retourner un message d'erreur avec les détails de l'erreur
//             return response()->json([
//                 'status' => false,
//                 'message' => 'Une erreur est survenue lors de la récupération des produits les plus vendus.',
//                 'error' => $error->getMessage()
//             ], 500);
//         }
//     }
// }
