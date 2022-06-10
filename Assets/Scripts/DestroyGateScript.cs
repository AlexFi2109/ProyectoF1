using UnityEngine;

public class DestroyGateScript : MonoBehaviour
{
    public bool destroygate = false;
    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        { 
            if(destroygate==true)
            {
                Destroy(gameObject);
            } 
        }
    }
    
}
