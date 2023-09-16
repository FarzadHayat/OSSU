public interface CoffeeMachineInterface {
    public void chooseFirstSelection();
    public void chooseSecondSelection();
}

public class OldCoffeeMachine {
    public void selectA(){
        System.out.println("Select A");
    }
    public void SelectB(){
        System.out.println("Select B");
    }
}

public class CoffeeTouchscreenAdapter implements CoffeeMachineInterface {
    private OldCoffeeMachine oldCoffeeMachine;

    public CoffeeFouchscreenAdapter(OldCoffeeMachine oldMachine) {
        this.oldCoffeeMachine = oldMachine;
    }

    public void chooseFirstSelection() {
        oldCoffeeMachine.selectA();
    }

    public void chooseSecondSelection() {
        oldCoffeeMachine.SelectB();
    }
}