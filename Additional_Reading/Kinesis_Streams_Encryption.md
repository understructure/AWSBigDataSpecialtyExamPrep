

http://docs.aws.amazon.com/streams/latest/dev/server-side-encryption.html

* SSE - uses an AWS KMS customer master key (CMK) you specify to provide encryption at rest within stream storage
* Data is encrypted before it's written to the Kinesis stream storage layer
* Data is decrypted after it’s retrieved from storage
* Producers and consumers don't need to manage master keys or cryptographic operations
* AWS KMS provides all the master keys that are used by the server-side encryption feature
* Preexisting data in an unencrypted stream is not encrypted after server-side encryption is enabled (only data put into stream since encryption was turned on)
* Kinesis Streams calls AWS KMS approximately every five minutes when it is rotating the data key
* The CMK for Kinesis that's managed by AWS is free
* Typical latency of PutRecord, PutRecords, and GetRecords increased by less than 100 μs (microseconds)
* Before you can use server-side encryption with a user-generated KMS master key, you must 
    * configure AWS KMS key policies to allow encryption of streams and 
    * encryption and decryption of stream records. 
    * Producers must have the kms:GenerateDataKey permission
    * Consumers must have the kms:Decrypt permission
    * Kinesis stream administrators must have authorization to call kms:List\* and kms:DescribeKey\*
