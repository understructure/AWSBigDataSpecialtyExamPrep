### Table Design - Constraints

* BIG TAKEAWAY - Really, only the NOT NULL is respected in Redshift

#### Column-level constraints - only NOT NULL is enforced

* PRIMARY KEY

* UNIQUE

* NOT NULL / NULL

* REFERENCES

#### Table constraints - NONE are enforced

* PRIMARY KEY

* FOREIGN KEY

* UNIQUE

* REFERENCES

* **Only** use constraints if your application uses them

* Query planner uses some constraints when building queries (e.g., PKs, FKs), in subqueries it helps order large joins, helps eliminate redundant joins

**For the Exam:**

* PKs and FKs can be defined but are NOT enforced

* They’re there to drive performance only or for information purposes

---

* [Back: Redshift Table Design - Compression (9:31)](Redshift_Table_Design_Compression.md)
* [Next: Redshift Table Design - Review Design (3:43)](Redshift_Table_Design_Review_Design_OPTIONAL.md)
