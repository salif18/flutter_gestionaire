const db = require('../db/mysqldb');
const Depenses = require('../models/depenser')
 
exports.addDepenses = async(req,res)=> {
    const {montants, motifs} = req.body;
    const depenses = new Depenses(montants, motifs)
    try{
      const results = await new Promise((resolve,reject)=>{
        db.query(`INSERT INTO depenses set ?`,depenses,(err,results)=>{
            if(err){
                reject(err)
            }else{ 
                resolve(results)
            }
        })
      });
      
      return res.status(201).json({message:'Dépense enregistrée avec succès !!'})
    }catch(err){
        console.log(err)
        return res.status(500).json({error:err.message})
    }
}

exports.getDepenses = async(req,res)=> {
    try{
      const results = await new Promise((resolve,reject)=>{
        db.query('SELECT*FROM depenses ORDER BY timestamps DESC',(err,results)=>{
            if(err){
                reject(err)
            }else{
                resolve(results)
            }
        })
      });
      return res.status(200).json(results)
    }catch(err){
        return res.status(500).json({error:err.message})
    }
}

exports.deleteDepenses = async(req,res)=> {
    const {id} = req.params;
    try{
      const results = await new Promise((resolve,reject)=>{
        db.query('DELETE FROM depenses WHERE id = ?',[id],(err,results)=>{
            if(err){
                reject(err)
            }else{
                resolve(results)
            }
        })
      });
      return res.status(200).json({message:'Dépense supprimée avec succès !!'})
    }catch(err){
        return res.status(500).json({error:err.message})
    }
}

//version en laravel
// <?php

// namespace App\Http\Controllers;

// use App\Models\Depense;
// use Illuminate\Http\Request;

// class DepenseController extends Controller
// {
//     // Ajouter une nouvelle dépense
//     public function addDepenses(Request $request)
//     {
//         // Récupérer les données de la requête
//         $data = $request->only(['montants', 'motifs']);

//         // Créer une nouvelle instance de Depense avec les données de la requête
//         $depense = new Depense();
//         $depense->montants = $data['montants'];
//         $depense->motifs = $data['motifs'];

//         try {
//             // Enregistrer la nouvelle dépense dans la base de données
//             $depense->save();

//             // Retourner une réponse JSON indiquant que la dépense a été enregistrée avec succès
//             return response()->json(['message' => 'Dépense enregistrée avec succès !!'], 201);
//         } catch (\Exception $err) {
//             // En cas d'erreur, retourner une réponse JSON avec le message d'erreur
//             return response()->json(['error' => $err->getMessage()], 500);
//         }
//     }

//     // Obtenir toutes les dépenses
//     public function getDepenses()
//     {
//         try {
//             // Récupérer toutes les dépenses ordonnées par timestamps DESC
//             $depenses = Depense::orderBy('timestamps', 'DESC')->get();

//             // Retourner une réponse JSON contenant toutes les dépenses
//             return response()->json($depenses, 200);
//         } catch (\Exception $err) {
//             // En cas d'erreur, retourner une réponse JSON avec le message d'erreur
//             return response()->json(['error' => $err->getMessage()], 500);
//         }
//     }

//     // Supprimer une dépense par son ID
//     public function deleteDepenses($id)
//     {
//         try {
//             // Rechercher la dépense par son ID et la supprimer
//             $depense = Depense::findOrFail($id);
//             $depense->delete();

//             // Retourner une réponse JSON indiquant que la dépense a été supprimée avec succès
//             return response()->json(['message' => 'Dépense supprimée avec succès !!'], 200);
//         } catch (\Exception $err) {
//             // En cas d'erreur, retourner une réponse JSON avec le message d'erreur
//             return response()->json(['error' => $err->getMessage()], 500);
//         }
//     }
// }
