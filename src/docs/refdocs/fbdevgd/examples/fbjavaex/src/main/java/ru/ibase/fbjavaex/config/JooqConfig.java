/**
 * Конфигурация IoC контейнера
 * для осуществления внедрения зависимостей.
 */
package ru.ibase.fbjavaex.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;
import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.TransactionAwareDataSourceProxy;
import org.jooq.impl.DataSourceConnectionProvider;
import org.jooq.DSLContext;
import org.jooq.impl.DefaultDSLContext;
import org.jooq.impl.DefaultConfiguration;
import org.jooq.SQLDialect;
import org.jooq.impl.DefaultExecuteListenerProvider;

import ru.ibase.fbjavaex.exception.ExceptionTranslator;

import ru.ibase.fbjavaex.managers.*;
import ru.ibase.fbjavaex.jqgrid.*;

/**
 * Конфигурационный класс Spring IoC контейнера
 */
@Configuration
public class JooqConfig {

    /**
     * Возвращает пул коннектов
     *
     * @return
     */
    @Bean(name = "dataSource")
    public DataSource getDataSource() {
        BasicDataSource dataSource = new BasicDataSource();
        // определяем конфигурацию подключения
        dataSource.setUrl("jdbc:firebirdsql://localhost:3050/examples");
        dataSource.setDriverClassName("org.firebirdsql.jdbc.FBDriver");
        dataSource.setUsername("SYSDBA");
        dataSource.setPassword("masterkey");
        dataSource.setConnectionProperties("charSet=utf-8");
        return dataSource;
    }

    /**
     * Возращает менеджер транзакций
     *
     * @return
     */
    @Bean(name = "transactionManager")
    public DataSourceTransactionManager getTransactionManager() {
        return new DataSourceTransactionManager(getDataSource());
    }

    @Bean(name = "transactionAwareDataSource")
    public TransactionAwareDataSourceProxy getTransactionAwareDataSource() {
        return new TransactionAwareDataSourceProxy(getDataSource());
    }

    /**
     * Возвращает провайдер подключений
     *
     * @return
     */
    @Bean(name = "connectionProvider")
    public DataSourceConnectionProvider getConnectionProvider() {
        return new DataSourceConnectionProvider(getTransactionAwareDataSource());
    }

    /**
     * Возвращает транслятор исключений
     *
     * @return
     */
    @Bean(name = "exceptionTranslator")
    public ExceptionTranslator getExceptionTranslator() {
        return new ExceptionTranslator();
    }

    /**
     * Возвращает конфгурацию DSL контекста
     *
     * @return
     */
    @Bean(name = "dslConfig")
    public org.jooq.Configuration getDslConfig() {
        DefaultConfiguration config = new DefaultConfiguration();
        // используем диалект SQL СУБД Firebird
        config.setSQLDialect(SQLDialect.FIREBIRD);
        config.setConnectionProvider(getConnectionProvider());
        DefaultExecuteListenerProvider listenerProvider = new DefaultExecuteListenerProvider(getExceptionTranslator());
        config.setExecuteListenerProvider(listenerProvider);
        return config;
    }

    /**
     * Возвращает DSL контекст
     *
     * @return
     */
    @Bean(name = "dsl")
    public DSLContext getDsl() {
        org.jooq.Configuration config = this.getDslConfig();
        return new DefaultDSLContext(config);
    }

    /**
     * Возвращает менеджер заказчиков
     *
     * @return
     */
    @Bean(name = "customerManager")
    public CustomerManager getCustomerManager() {
        return new CustomerManager();
    }

    /**
     * Возвращает грид с заказчиками
     *
     * @return
     */
    @Bean(name = "customerGrid")
    public JqGridCustomer getCustomerGrid() {
        return new JqGridCustomer();
    }

    /**
     * Возвращает менеджер продуктов
     *
     * @return
     */
    @Bean(name = "productManager")
    public ProductManager getProductManager() {
        return new ProductManager();
    }

    /**
     * Возвращает грид с товарами
     *
     * @return
     */
    @Bean(name = "productGrid")
    public JqGridProduct getProductGrid() {
        return new JqGridProduct();
    }

    /**
     * Возвращает менеджер счёт фактур
     *
     * @return
     */
    @Bean(name = "invoiceManager")
    public InvoiceManager getInvoiceManager() {
        return new InvoiceManager();
    }

    /**
     * Возвращает грид с заголовками счёт фактур
     *
     * @return
     */
    @Bean(name = "invoiceGrid")
    public JqGridInvoice getInvoiceGrid() {
        return new JqGridInvoice();
    }

    /**
     * Возвращет грид с позициями счёт фактуры
     *
     * @return
     */
    @Bean(name = "invoiceLineGrid")
    public JqGridInvoiceLine getInvoiceLineGrid() {
        return new JqGridInvoiceLine();
    }

    /**
     * Возвращает рабочий период
     * 
     * @return 
     */
    @Bean(name = "workingPeriod")
    public WorkingPeriod getWorkingPeriod() {
        return new WorkingPeriod();
    }

}
