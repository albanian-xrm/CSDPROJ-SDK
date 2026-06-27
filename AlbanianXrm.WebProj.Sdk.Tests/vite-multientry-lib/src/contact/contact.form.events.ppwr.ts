export class ContactFormEvents {
    public static onLoad(executionContext: Xrm.Events.EventContext): void {
        const formContext = executionContext.getFormContext();
        console.log("ContactFormEvents.onLoad called");
        console.log("Form Type: " + formContext.ui.getFormType());
    }
}