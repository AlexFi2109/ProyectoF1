using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LogicalHeadScript : MonoBehaviour
{
    public int timerCollider = 0;       

    void OnTriggerEnter(Collider other)
    {
        timerCollider++;
    }

    void OnTriggerExit(Collider other)
    {
        timerCollider--;
    }
}
