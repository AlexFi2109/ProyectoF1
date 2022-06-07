using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ArcoScript : MonoBehaviour
{
    public Animator animator;
    private float counter,counter2;
    public float timeToShoot;
    public float energy;
    public float shootForce;
    public float energyNeededToShoot;
    public GameObject shootPoint;
    public GameObject prefabToShoot;
    public GameObject arco;
    private GameObject shootedPrefab;
    private int a=0; //Condicion para que no genere dos flechas encimadas
    private float h;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        counter += Time.deltaTime;
        counter2 += Time.deltaTime;
        
        if (counter >= timeToShoot && Input.GetButtonDown("Fire1") && energy >= energyNeededToShoot && a==0)
        {
            shootedPrefab = Instantiate(prefabToShoot, shootPoint.transform.position, shootPoint.transform.rotation);
            a = 1;
            animator.SetBool("Apunta", true);
            animator.SetBool("Dispara", false);
            shootedPrefab.transform.parent = arco.transform;
        }
        if (counter >= timeToShoot + 0.15 && Input.GetButtonDown("Fire2") && energy >= energyNeededToShoot)
        {
            shootedPrefab.GetComponent<Rigidbody>().useGravity = true;
            counter = 0;
            energy -= energyNeededToShoot;
            animator.SetBool("Apunta", false);
            animator.SetBool("Dispara", true);
            counter2 = 0;
            shootedPrefab.GetComponent<Rigidbody>().AddRelativeForce(shootForce * Vector3.up);
            a = 0;
            h = shootedPrefab.GetComponent<Transform>().position.y;
        }
        if (h <= 0.1 && a == 0)
        {
            Destroy(shootedPrefab);
            counter2 = 0;
        }

    }
    private void Shoot()
    {
        
        //audioSource.PlayOneShot(shootClip);
        //energyBar.fillAmount = (float)energy / 100f;
        

    }

}
