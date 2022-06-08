using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StartPursuitLifePointsScript : MonoBehaviour
{
    void Start()
    {
    }

    public void Start(float time)
    {
        StartCoroutine(DelayPursuit(time));
    }

    private IEnumerator DelayPursuit(float time)
    {
        yield return new WaitForSeconds(time);
        GetComponent<LifePointsNMScript>().startPursuit = true;
    }
}
