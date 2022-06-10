using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ArrowControllerScript : MonoBehaviour
{
    private int damage=25; //Daño de la flecha

    public float forceArrow; //Potencia final

    public bool movArrow; //Flecha en vuelo

    public GameObject sumArrow;
    Quaternion rotate;

    private void Start()
    {
        sumArrow = GameObject.FindGameObjectWithTag("Bow");
        movArrow = false;
        rotate = Quaternion.Euler(90, 0, 0);

    }

    private void Update()
    {
        if(movArrow==true && forceArrow<=30)
        {
            transform.rotation=Quaternion.Lerp(transform.rotation, rotate, 0.5f * Time.deltaTime);
        }
    }
    private void OnCollisionEnter(Collision collision)
    {
        GetComponent<Rigidbody>().isKinematic = true;
        GetComponent<CapsuleCollider>().isTrigger = true;
        movArrow = false;
        
        Debug.Log("Generaste" + "daño" + "al objeto"); //Aqui va el codigo para el daño al enemigo

        StartCoroutine(timeToDestruction());
    }
    public void TakeArrow()
    {
        sumArrow.GetComponent<MovArrowSrcipt>().cantArrow +=1;
        Destroy(gameObject);
    }

    IEnumerator timeToDestruction()
    {
        yield return new WaitForSeconds(60);
        Destroy(gameObject);
    }

}
