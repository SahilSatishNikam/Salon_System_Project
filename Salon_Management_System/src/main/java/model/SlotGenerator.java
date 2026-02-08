package model;

import java.time.LocalTime;
import java.util.*;

public class SlotGenerator {

    public static List<LocalTime> generateSlots(
            LocalTime start,
            LocalTime end,
            int minutes) {

        List<LocalTime> list = new ArrayList<>();

        while(start.isBefore(end)) {
            list.add(start);
            start = start.plusMinutes(minutes);
        }

        return list;
    }
}
