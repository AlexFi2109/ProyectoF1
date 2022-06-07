using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ArcoScript : MonoBehaviour
{
    public Animator animator;
    private float counter;
    public float timeToShoot;
    public float energy;
    public float shootForce;
    public float energyNeededToShoot;
    public GameObject shootPoint;
    public GameObject prefabToShoot;
    private GameObject shootedPrefab;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        counter += Time.deltaTime;

        if (counter >= timeToShoot && Input.GetButtonDown("Fire1") && energy >= energyNeededToShoot)
        {
            shootedPrefab = Instantiate(prefabToShoot, shootPoint.transform.position, shootPoint.transform.rotation);
            animator.SetBool("Apunta", true);
            animator.SetBool("Dispara", false);
        }
        if (counter >= timeToShoot + 0.15 && Input.GetButtonDown("Fire2") && energy >= energyNeededToShoot)
        {
            counter = 0;
            energy -= energyNeededToShoot;
            animator.SetBool("Apunta", false);
            animator.SetBool("Dispara", true);
            shootedPrefab.GetComponent<Rigidbody>().AddRelativeForce(shootForce * Vector3.up);
        }

    }
    private void Shoot()
    {
        
        //audioSource.PlayOneShot(shootClip);
        //energyBar.fillAmount = (float)energy / 100f;
        

    }

}
