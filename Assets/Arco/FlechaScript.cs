using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlechaScript : MonoBehaviour
{
    public float h;

    // Start is called before the first frame update
    void Start()
    {
        h = GetComponent<Transform>().position.y;
    }

    // Update is called once per frame
    void Update()
    {
        if (h<=2)
        {
            Destroy(this);
        }
    }

}
