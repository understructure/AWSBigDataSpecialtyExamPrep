### Glacier

* Keep all your data at much lower cost

* Compliance requirement to keep your data (e.g., financial services industry)

* Need to show auditors that data cannot be changed or deleted

* Vault Lock - can use console, API or CLI

    * Deploy and enforce controls for a vault with a vault lock policy

    * Policies can be locked from editing

    * Policies cannot be changed after locking

    * Enforce compliance controls

    * Policies created using IAM

* [http://docs.aws.amazon.com/amazonglacier/latest/dev/vault-lock.html](http://docs.aws.amazon.com/amazonglacier/latest/dev/vault-lock.html)

* Steps for Vault Lock

    * Initial Vault Lock

        * Attaches Vault Lock policy to vault

        * Lock is then set to an InProgress state, lock ID is returned

        * You then have 24 hours to validate the lock, or it expires

    * Complete Vault Lock

        * Now goes from InProgress state → Locked state (immutable)

**For the exam, know:**

* Vault lock controls - time-based retention, "undeleteable" or both

* Implement control using IAM policies
