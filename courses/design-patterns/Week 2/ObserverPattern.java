import java.util.ArrayList;

public class Subject {
    private ArrayList<Observer> observers = new ArrayList<Observer>();

    public void registerObserver(Observer observer) {
        observers.add(observer);
    }

    public void unregisterObserver(Observer observer) {
        observers.remove(observer);
    }

    public void notifyObservers() {
        for (Observer observer : observers) {
            observer.update();
        }
    }
}

public class Auction extends Subject {
    private String state;

    public String getState() {
        return state;
    }

    // auction responsibilities...
}

public interface Observer {
    public void update();
}

public class Bidder extends Observer {
    public void update() {
        System.out.println("Update bidder");
    }
}