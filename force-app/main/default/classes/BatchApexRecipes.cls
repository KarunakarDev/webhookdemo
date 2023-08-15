public class BatchApexRecipes implements Database.Batchable<SObject>, Database.Stateful {

    private List<Id> successes = new List<Id>();
    private List<Id> failures = new List<Id>();
    
    private final String queryString = 'SELECT Id, Name FROM Account';
    
    @testVisible
    private static String result = '';
    
    @testVisible
    private Boolean throwError = false;
    
    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator(queryString);
    }
    
    public void execute(Database.BatchableContext context, List<Account> scope) {
        // Batch Processing
        for (Account acct : scope) {
            acct.Name += ' Edited by Batch class';
            if (this.throwError) {
                acct.Name = null;
            }
        }
        
        List<Database.SaveResult> saveResults = new List<Database.SaveResult>();
        saveResults = Database.update(scope, false);
        for (Database.SaveResult sr : saveResults) {
            if (sr.isSuccess()) {
                // Only available *across* scope executions because of
                // Database.stateful
                successes.add(sr.id);
            } else {
                // Only available *across* scope executions because of
                // Database.stateful
                failures.add(sr.id);
            }
        }
    }
        
        public void finish(Database.BatchableContext context) {
        BatchApexRecipes.result =
            'Successes: ' +
            successes.size() +
            ' Failures: ' +
            failures.size();
    }
}