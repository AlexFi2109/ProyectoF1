using UnityEngine;

public class HitPlayerScript : MonoBehaviour
{
    public int damageToPlayer;

    private void OnCollisionEnter(Collision collision)
    {
        if(collision.gameObject.CompareTag("Player"))
        {
            collision.gameObject.GetComponent<PlayerHealthScript>().DamagePlayer(damageToPlayer);
        }
        Destroy(gameObject);
    }
}
