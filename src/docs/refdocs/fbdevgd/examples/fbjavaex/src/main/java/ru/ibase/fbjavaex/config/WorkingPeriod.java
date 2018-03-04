package ru.ibase.fbjavaex.config;

import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 * Working period
 *
 * @author Simonov Denis
 */
public class WorkingPeriod {

    private Timestamp beginDate;
    private Timestamp endDate;

    /**
     * Constructor
     */
    WorkingPeriod() {
        // in real applications is calculated from the current date
        this.beginDate = Timestamp.valueOf("2015-06-01 00:00:00");
        this.endDate = Timestamp.valueOf(LocalDateTime.now().plusDays(1));
    }

    /**
     * Returns the start date of the work period
     *
     * @return
     */
    public Timestamp getBeginDate() {
        return this.beginDate;
    }

    /**
     * Returns the end date of the work period
     *
     * @return
     */
    public Timestamp getEndDate() {
        return this.endDate;
    }

    /**
     * Setting the start date of the work period
     *
     * @param value
     */
    public void setBeginDate(Timestamp value) {
        this.beginDate = value;
    }

    /**
     * Setting the end date of the work period
     *
     * @param value
     */
    public void setEndDate(Timestamp value) {
        this.endDate = value;
    }

    /**
     * Setting the working period
     *
     * @param beginDate
     * @param endDate
     */
    public void setRangeDate(Timestamp beginDate, Timestamp endDate) {
        this.beginDate = beginDate;
        this.endDate = endDate;
    }
}
