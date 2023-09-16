import java.util.ArrayList;

// Subject.java
public interface Subject {
    public void registerObserver(Observer observer);
    public void unregisterObserver(Observer observer);
    public void notifyObservers();
}

// Channel.java
public class Channel implements Subject {
    
    private ArrayList<Observer> observers = new ArrayList<Observer>();
    private String channelName;
    private String status;

    public Channel(String channelName, String status) {
        this.channelName = channelName;
        this.status = status;
    }

    public String getChannelName() {
        return this.channelName;
    }

    public void setChannelName(String channelName) {
        this.channelName = channelName;
    }

    public String getStatus() {
        return this.status;
    }

    public void setStatus(String status) {
        this.status = status;
        notifyObservers();
    }

    public void notifyObservers() {
        for (Observer observer : observers) {
            observer.update(status);
        }
    }

    public void registerObserver(Observer observer) {
        observers.add(observer);
    }

    public void unregisterObserver(Observer observer) {
        observers.remove(observer);
    }
}

// Observer.java
public interface Observer {
	public void update(String status);
}

// Follower.java
public class Follower implements Observer {

    private String followerName;

    public Follow(String followerName) {
        this.followerName = followerName;
    }

    public String getFollowName() {
        return followerName;
    }

    public void setFollowerName(String followerName) {
        this.followerName = followerName;
    }

    public void update(String status) {
        // send message to followers that Channel is live.
    }

    public void play() {
        // play channel live stream
    }
}