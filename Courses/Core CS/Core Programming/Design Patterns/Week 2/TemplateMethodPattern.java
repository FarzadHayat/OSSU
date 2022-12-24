public abstract class SelfDrivingVehicle{
    public final void driveToDestination() {
        accelerate();
        steer();
        brake();
        reachDestination();
    }

    abstract void steer();
    abstract void accelerate();
    abstract void brake();

    private void reachDestination() {
        System.out.println("Destination reached");
    }
}

public class SelfDrivingCar extends SelfDrivingVehicle {
    public void steer() {
        System.out.println("Turning steering wheel");
    }
    
    public void accelerate() {
        System.out.println("Pushing gas pedal");
    }

    public void brake() {
        System.out.println("Pushing brake pedal");
    }
}

public class SelfDrivingMotorcycle extends SelfDrivingVehicle {
    public void steer() {
        System.out.println("Turning steering handles");
    }
    
    public void accelerate() {
        System.out.println("Twisting throttle");
    }

    public void brake() {
        System.out.println("Pulling brake lever");
    }
}