export namespace ShkoOnline { 
export class AccountInformationFormEvents {
    public static onLoad(executionContext: Xrm.Events.EventContext): void {
        const formContext = executionContext.getFormContext();
        console.log("AccountInformationFormEvents.onLoad called");
        console.log("Form Type: " + formContext.ui.getFormType());
    }
}
}
