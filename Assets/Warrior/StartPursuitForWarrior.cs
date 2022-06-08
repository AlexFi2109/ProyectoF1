using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StartPursuitForWarrior : MonoBehaviour
{
    public GameObject brother;
    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            GetComponentInParent<PruebaScript>().startPursuit = true;
            brother.GetComponent<PruebaScript>().startPursuit = true;
        }
    }
}
