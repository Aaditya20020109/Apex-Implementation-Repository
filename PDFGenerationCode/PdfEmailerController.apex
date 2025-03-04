


public class PdfEmailerController {
    public Account account {get; set;}
    
    public List<Opportunity> wonOppList {get; set;}
    public List<Opportunity> notWonOppList {get; set;}
    
    public PdfEmailerController(){
        this.account = [SELECT Id, Name, BillingStreet, BillingCity, BillingState, 
                        BillingPostalCode, BillingCountry
                        FROM Account
                        limit 1
                       ];
        
        this.wonOppList = [SELECT Name, Amount, CloseDate
                           FROM Opportunity
                           WHERE AccountId = :this.account.Id 
                           AND StageName = 'Closed Won'                              
                          ];
        
        this.notWonOppList = [SELECT Name, Amount, StageName
                              FROM Opportunity
                              WHERE AccountId =:this.account.Id
                              AND StageName != 'Closed Won'
                             ];
    }
    
    public static void main()
    {
        
        PageReference pageRef = new PageReference('/apex/PDF_Page'); // Replace with your page name
        
        Blob pdfData = pageRef.getContentAsPDF(); 
        
        
        
        system.debug('pdfData--->' + pdfData);



        
    }
}
