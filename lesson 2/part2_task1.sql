/* ������� 1
 * ����� � ������� catalogs ���� ������ shop � ������ name ����� ���������� ������ ������
 * � ���� ����������� �������� NULL. �������� ������, ������� �������� ��� ����� ���� �� ������ �empty�. 
 * �������, ��� �� ����� �� ���������� ������������ �� ���� name.
 * �������� �� �������� ��� �������? ������?
*/

-- �������� �������
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT '�������� �������'/*,
	UNIQUE unique_name(name(10))*/
) COMMENT = '������� ��������-��������';

-- �������� �������
INSERT INTO catalogs VALUES
(NULL, NULL),
(NULL, ''),
(NULL, '����������');

-- ������� NULL � ''
UPDATE catalogs SET name='empty' WHERE name='' OR name is NULL;
SELECT * FROM catalogs; 



