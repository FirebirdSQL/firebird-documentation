/**
 * IoC container configuration
 * to implement dependency injection.
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
 * Return connection pool
 *
 * @return
 */
@Configuration
public class JooqConfig {

    /**
     * Return connection pool
     *
     * @return
     */
    @Bean(name = "dataSource")
    public DataSource getDataSource() {
        BasicDataSource dataSource = new BasicDataSource();
        // JDBC connection configuration
        dataSource.setUrl("jdbc:firebirdsql://localhost:3053/examples");
        dataSource.setDriverClassName("org.firebirdsql.jdbc.FBDriver");
        dataSource.setUsername("SYSDBA");
        dataSource.setPassword("masterkey");
        dataSource.setConnectionProperties("charSet=utf-8");
        return dataSource;
    }

    /**
     * Return transaction manager
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
     * Return connection provider
     *
     * @return
     */
    @Bean(name = "connectionProvider")
    public DataSourceConnectionProvider getConnectionProvider() {
        return new DataSourceConnectionProvider(getTransactionAwareDataSource());
    }

    /**
     * Return exception translator
     *
     * @return
     */
    @Bean(name = "exceptionTranslator")
    public ExceptionTranslator getExceptionTranslator() {
        return new ExceptionTranslator();
    }

    /**
     * Returns the DSL context configuration
     *
     * @return
     */
    @Bean(name = "dslConfig")
    public org.jooq.Configuration getDslConfig() {
        DefaultConfiguration config = new DefaultConfiguration();
        // use the dialect SQL DBMS Firebird
        config.setSQLDialect(SQLDialect.FIREBIRD);
        config.setConnectionProvider(getConnectionProvider());
        DefaultExecuteListenerProvider listenerProvider = new DefaultExecuteListenerProvider(getExceptionTranslator());
        config.setExecuteListenerProvider(listenerProvider);
        return config;
    }

    /**
     * Return DSL context
     *
     * @return
     */
    @Bean(name = "dsl")
    public DSLContext getDsl() {
        org.jooq.Configuration config = this.getDslConfig();
        return new DefaultDSLContext(config);
    }

    /**
     * Return customer manager
     *
     * @return
     */
    @Bean(name = "customerManager")
    public CustomerManager getCustomerManager() {
        return new CustomerManager();
    }

    /**
     * Return customer grid
     *
     * @return
     */
    @Bean(name = "customerGrid")
    public JqGridCustomer getCustomerGrid() {
        return new JqGridCustomer();
    }

    /**
     * Return product manager
     *
     * @return
     */
    @Bean(name = "productManager")
    public ProductManager getProductManager() {
        return new ProductManager();
    }

    /**
     * Return product grid
     *
     * @return
     */
    @Bean(name = "productGrid")
    public JqGridProduct getProductGrid() {
        return new JqGridProduct();
    }

    /**
     * Return invoice manager
     *
     * @return
     */
    @Bean(name = "invoiceManager")
    public InvoiceManager getInvoiceManager() {
        return new InvoiceManager();
    }

    /**
     * Return invoice grid
     *
     * @return
     */
    @Bean(name = "invoiceGrid")
    public JqGridInvoice getInvoiceGrid() {
        return new JqGridInvoice();
    }

    /**
     * Return invoice items grid
     *
     * @return
     */
    @Bean(name = "invoiceLineGrid")
    public JqGridInvoiceLine getInvoiceLineGrid() {
        return new JqGridInvoiceLine();
    }

    /**
     * Return working period
     *
     * @return
     */
    @Bean(name = "workingPeriod")
    public WorkingPeriod getWorkingPeriod() {
        return new WorkingPeriod();
    }

}
