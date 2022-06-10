using UnityEngine;

public class EnemyHealthScript : MonoBehaviour
{
    public int enemyHealth = 100, damageArrow;
    void Start()
    {
        
    }

    public void DamageEnemy(int damage)
    {
        enemyHealth -= damage;

        if(enemyHealth<=0)
        {
            //Destroy(gameObject);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Arrow"))
        {

            enemyHealth -= damageArrow;
            
        }

    }

    void Update()
    {
        
    }
}
