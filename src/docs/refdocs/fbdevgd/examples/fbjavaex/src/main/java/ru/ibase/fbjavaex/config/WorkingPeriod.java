package ru.ibase.fbjavaex.config;

import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 * Рабочий период
 *
 * @author Simonov Denis
 */
public class WorkingPeriod {

    private Timestamp beginDate;
    private Timestamp endDate;

    /**
     * Конструктор
     */
    WorkingPeriod() {
        // в реальных приложениях вычисляется от текущей даты
        this.beginDate = Timestamp.valueOf("2015-06-01 00:00:00");
        this.endDate = Timestamp.valueOf(LocalDateTime.now().plusDays(1));
    }

    /**
     * Возвращает дату начала рабочего периода
     *
     * @return
     */
    public Timestamp getBeginDate() {
        return this.beginDate;
    }

    /**
     * Возвращает дату окончания рабочего периода
     * 
     * @return
     */
    public Timestamp getEndDate() {
        return this.endDate;
    }

    /**
     * Установка даты начала рабочего периода
     * 
     * @param value
     */
    public void setBeginDate(Timestamp value) {
        this.beginDate = value;
    }

    /**
     * Установка даты окончания рабочего периода
     * 
     * @param value
     */
    public void setEndDate(Timestamp value) {
        this.endDate = value;
    }

    /**
     * Установка рабочего периода
     * 
     * @param beginDate
     * @param endDate
     */
    public void setRangeDate(Timestamp beginDate, Timestamp endDate) {
        this.beginDate = beginDate;
        this.endDate = endDate;
    }
}
