--Criar procedure insere_projeto
CREATE OR REPLACE PROCEDURE brh.insere_projeto
    (p_ID IN brh.projeto.ID%type, 
     p_NOME IN brh.projeto.NOME%type, 
     p_RESPONSAVEL IN brh.projeto.RESPONSAVEL%type, 
     p_INICIO IN brh.projeto.INICIO%type DEFAULT SYSDATE)
IS    
BEGIN
    INSERT INTO brh.projeto(ID, NOME, RESPONSAVEL, INICIO)
    VALUES
    (p_ID, upper(p_NOME), upper(p_RESPONSAVEL), p_INICIO);
    
    EXCEPTION 
       WHEN DUP_VAL_ON_INDEX then
            RAISE_APPLICATION_ERROR(-20001, 'ID j� cadastrado!!!');
        WHEN OTHERS
            THEN
            DBMS_OUTPUT.PUT_LINE('ERRO Oralcle: ' || SQLCODE || SQLERRM);
END;


EXECUTE brh.insere_projeto( 6, 'NEW_TEST', 'P123', SYSDATE); 
COMMIT;

SELECT * FROM brh.projeto;

--DELETE FROM brh.projeto WHERE ID > 4;



--2. Criar fun��o calcula_idade
CREATE OR REPLACE FUNCTION brh.calcula_idade
        (p_data IN DATE)
        RETURN INT
    IS
        e_data_invalida EXCEPTION;
BEGIN  
    IF p_data > SYSDATE OR p_data IS NULL
        THEN RAISE e_data_invalida;
    ELSE
        RETURN INT(NVL(FLOOR((MONTHS_BETWEEN(SYSDATE, p_data) / 12)), 0));
    END IF;

    EXCEPTION 
        WHEN e_data_invalida
            THEN raise_application_error(-20001, 'Imposs�vel calcular idade! Data inv�lida: ' || p_data);
END;
    
    
SELECT brh.calcula_idade (TO_DATE('01/01/2000', 'dd/mm/yyyy')) FROM DUAL;


