using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraControlScript : MonoBehaviour
{    
    public GameObject[] listCamera;
    int numberCamera = 2;
    
    void Start()
    {        
        for(int i=0; i<numberCamera;i++)
        {
            listCamera[i].gameObject.SetActive(false);
        }
        listCamera[0].gameObject.SetActive(true);
    }
    
    void Update()
    {        
        if(Input.GetKey(KeyCode.Alpha9))
        {
            ControlCamera();
            listCamera[1].gameObject.SetActive(true);
        }
        else
        {
            listCamera[1].gameObject.SetActive(false);
            listCamera[0].gameObject.SetActive(true);
        }        
    }
    void ControlCamera()
    {
        for (int i = 0; i < numberCamera; i++)
        {
            listCamera[i].gameObject.SetActive(false);
            
        }

    }
}
