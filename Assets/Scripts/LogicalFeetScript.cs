using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LogicalFeetScript : MonoBehaviour
{
    public FPSControllerXaya logicFeetXaya;

    private void OnTriggerStay(Collider other)
    {
        logicFeetXaya.jump = true;
    }
    private void OnTriggerExit(Collider other)
    {
        logicFeetXaya.jump = false;
    }
}
