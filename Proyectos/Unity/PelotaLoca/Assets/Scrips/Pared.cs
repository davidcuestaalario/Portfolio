using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Pared : MonoBehaviour
{
	// ######################################## //
    // ############## VARIABLES ############### //
    // ######################################## //
	
    // -------------- Constantes -------------- //
	
    // --------------- Variables -------------- //
	
	// ----------------- Flags ---------------- //
	
	// ---------------- Modelo ---------------- //

    // ######################################## //
    // ############## CONSTRUCTOR ############# //
    // ######################################## //
    
	void Awake(){}
    void Start(){}
	
    // ######################################## //
    // ########## GETTERS Y SETTERS ########### //
    // ######################################## //
	
    // ######################################## //
    // ############### EVENTOS ################ //
    // ######################################## //

    // ######################################## //
    // ############## COLISIONES ############## //
    // ######################################## //

    private void OnCollisionEnter( Collision pCollision )
    {
        if( pCollision.collider.CompareTag("Jugador") )
        { 
            pCollision.collider.transform.parent.gameObject.GetComponent<AgentePelota>().chocarPared();
        }
    }

    // ######################################## //
    // ############## CORRUTINAS ############## //
    // ######################################## //
    
    // ######################################## //
    // ################ FLUJO ################# //
    // ######################################## //
	
    void Update(){}

    // ######################################## //
    // ############## ESPECIALES ############## //
    // ######################################## //

    // ######################################## //
    // ################ DEBUG ################# //
    // ######################################## //
	
}
