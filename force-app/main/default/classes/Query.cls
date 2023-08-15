public virtual inherited sharing class Query
{
    static Query service = new Query();
    @TestVisible static void setMock(Query mock) { service = mock; }

    public static Integer count(Integer recordCount)
    {
        return service.passThrough(recordCount);
    }
    public static List<SObject> records(List<SObject> records)
    {
        return service.passThrough(records);
    }
    
    protected virtual Integer passThrough(Integer recordCount)
    {
        return recordCount;
    }
    protected virtual List<SObject> passThrough(List<SObject> records)
    {
        return records;
    }

}