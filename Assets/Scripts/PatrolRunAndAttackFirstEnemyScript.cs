using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PatrolRunAndAttackFirstEnemyScript : MonoBehaviour
{
    public int rutina;
    
    public float timer; //Cronometro
    public float grade; //Grado del ángulo    
    public float timeToExplode = 5f; //

    public bool attack;
    public bool died;  
  

    public Animator anim;
    public Quaternion angle;  //Ángulo para la ratoacion del enemigo
    public GameObject target;
    
    private GameObject player;
    

    void Start()
    {
        anim = GetComponent<Animator>();
        target = GameObject.Find("Xaya");
        player = GameObject.FindGameObjectWithTag("Player");   
    }
    
    void Update()
    {
        int health = GetComponent<EnemyHealthScript>().enemyHealth;

        if (health > 0) //
        {
            EnemyAlive();            
        }        
        else
        {
            if(!died)
            {
                anim.SetTrigger("Die");                
                GetComponent<ExplodeWhenDieScript>().Explode(timeToExplode);
                died = true;
            }
        }
    }

    public void BehaviourEnemy()
    {

        if (Vector3.Distance(transform.position, target.transform.position) > 5)
        {
            anim.SetBool("Run", false); //Cancela animación de correr
            timer += 1 * Time.deltaTime;
            if (timer >= 4)
            {
                rutina = Random.Range(0, 2);
                timer = 0;
            }
            switch (rutina)
            {
                case 0: //Enemigo se queda quieto
                    anim.SetBool("Walk", false);
                    break;

                case 1: //Dirección del desplazamiento del enemigo
                    grade = Random.Range(0, 360);
                    angle = Quaternion.Euler(0, grade, 0);
                    rutina++;
                    break;
                case 2: // Rotación del enemigo
                    transform.rotation = Quaternion.RotateTowards(transform.rotation, angle, 0.5f);
                    transform.Translate(Vector3.forward * 1 * Time.deltaTime);
                    anim.SetBool("Walk", true);
                    break;
            }
        }
        else
        {
            var lookPos = target.transform.position - transform.position;
            lookPos.y = 0;
            var rotation = Quaternion.LookRotation(lookPos);

            if (Vector3.Distance(transform.position, target.transform.position) > 1 && !attack)
            {       
                transform.rotation = Quaternion.RotateTowards(transform.rotation, rotation, 2);
                anim.SetBool("Walk", false);
                anim.SetBool("Run", true);
                transform.Translate(Vector3.forward * 2 * Time.deltaTime);
                anim.SetBool("Attack", false);
            }
            else
            {
                transform.rotation = Quaternion.RotateTowards(transform.rotation, rotation, 2);
                anim.SetBool("Walk", false);
                anim.SetBool("Run", false);
                anim.SetBool("Attack", true);                

                attack = true;
            }
        }
        
    }

    public void FinalAttack()
    {
        rutina = 0;
        anim.SetBool("Attack", false);
        attack = false;
    }
    public void EnemyAlive()
    {
        BehaviourEnemy();
    }
    
}
