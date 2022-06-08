using UnityEngine;

public class StartPursuitHakScript : MonoBehaviour
{
    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            GetComponentInParent<HakScript>().startPursuit = true;
        }
    }
}
