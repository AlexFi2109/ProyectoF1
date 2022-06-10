using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovArrowSrcipt : MonoBehaviour
{    
    public int cantArrow;

    public GameObject arrow;
    [SerializeField]
    private GameObject arrowPrefab;

    [SerializeField]
    private Transform respawnArrow, chargeArrow;

    //Mira
    
    private float power;

    public float force;


    private void Start() //Mira
    {
        
    }

    private void Update()
    {
        float mov = 0.5f + force; //Forma de carga de la flecha
        if(cantArrow>0 && arrow==null)
        {
            if(Input.GetKeyDown(KeyCode.I))
            {
                arrow = Instantiate(arrowPrefab, respawnArrow.position, respawnArrow.rotation);
                arrow.transform.SetParent(respawnArrow);
            }
        }
        if(Input.GetKey(KeyCode.O) && arrow!=null)
        {
            power += 0.2f + force;
            power = Mathf.Clamp(power, 0, 30);
            arrow.GetComponent<ArrowControllerScript>().forceArrow = power;
            arrow.transform.position = Vector3.Lerp(arrow.transform.position, chargeArrow.position, mov * Time.deltaTime);
        }
        if(Input.GetKeyUp(KeyCode.O) && arrow!=null)
        {
            arrow.GetComponent<Rigidbody>().velocity = transform.forward * power;
            arrow.GetComponent<Rigidbody>().isKinematic = false;
            arrow.GetComponent<ArrowControllerScript>().movArrow = true;
            arrow.transform.SetParent(null);
            arrow = null;
            power = 0;
            cantArrow -= 1;
        }
    }    
    
}
