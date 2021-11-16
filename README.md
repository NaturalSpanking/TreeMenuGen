# TreeMenuGen
Tree menus generator for MCUs.

Генератор древовидных меню для микроконтроллеров. 

Работает в паре с [библиотекой](https://github.com/NaturalSpanking/tree_menu) древовидных меню.
# Содержание
- [Установка](#install)
- [Описание дерева](#tree)
- [Использование](#usage)
- [Выходной файл](#output)

<a id="install"></a>
## Установка
Установка не требуется. Для работы достаточно скачать и запустить исполняемый файл `/Win32/Release/TreeMenuGenerator.exe`.

<a id="usage"></a>
## Использование
1. Построить дерево кнопками `Add root` и `Add child`.
2. Заполнить поля узлов, зафиксировав кнопкой `Apply`.
3. Создать выходной файл кнопкой `Generate`.
4. Скопировать содержимое в целевой проект.

<a id="tree"></a>
## Описание дерева
Каждый узел в дереве может быть:
- Подменю - включает в себя другие узлы, при переходе первый дочерний узел становится основным;
- Командой - не содержит значений, при переходе вызывается обработчик команды;
- Параметром - содержит изменяемое (поразрадно) значение, при переходе выбирается разряд для редактирования.

Каждый узел содержит поля:
- `id` - идентификатор узла, индекс в выходном массиве;
- `parent_id` - идентификатор родителя, индекс родителя в выходном массиве;
- `Is parameter` - признак параметра, не может быть `true` для подменю;
- `Name` - имя узла;
- `Init value` - начальное значение;
- `Min value` - минимальное значение;
- `Max value` - максимальное значение;
- `Init delta` - начальный разряд для изменения;
- `Min delta` - минимальный разряд;
- `Max delta` - максимальный разряд;

Поля `value` и `delta` актуальны только для параметров.

Переходы по дереву:
- Влево\вправо - смена узла, выбор разряда или изменение значения разряда;
- Вперед\назад - смена узла, выполнение команды, переход к выбору разряда, или переход к изменению значения.
- Спец. функция - дополнительная команда, например сохранение в EEPROM.

<a id="output"></a>
## Выходной файл
Выходной файл содержит:
1. Размер меню.
```c
#define TM_MENU_SIZE 6
```
2. Массив узлов.
```c
const TM_Unit menu[TM_MENU_SIZE]={
  {-1, true, "Menu0", 0, 100, 1, 100},
  {-1, false, "Menu1", 0, 100, 1, 100},
    {1, true, "Menu4", 0, 100, 1, 100},
    {1, true, "Menu5", 0, 100, 1, 100},
  {-1, true, "Menu2", 0, 100, 1, 100},
  {-1, true, "Menu3", 0, 100, 1, 100}
};
```
3. Массив параметров.
```c
TM_Param params[TM_MENU_SIZE]={
  {0, 10},{0, 10},{0, 10},{0, 10},{0, 10},
  {0, 10}
};
```
4. Прототип функции вывода. Вызывается при переходе по меню.
```c
void PrintMenu(int index,TM_DeepLevel DeepLevel){
  // printing function prototype
  switch(DeepLevel){
    case DL_NAME: // print name

    break;
    case DL_DELTA: // print param with cursor on symbol which will be change

    break;
    case DL_PARAM: // print param with cursor on symbol which changing

    break;
  }
}
```
5. Прототип функции изменения. Вызывается при изменении параметра.
```c
void ChangeParam(int index){
  // change parameter function prototype
  switch(index){
    case 0: // Menu0

    break; // end of Menu0
    case 2: // Menu4

    break; // end of Menu4
    case 3: // Menu5

    break; // end of Menu5
    case 4: // Menu2

    break; // end of Menu2
    case 5: // Menu3

    break; // end of Menu3
    default:
    break;
  }
}
```
6. Прототип функции выполнения. Вызывается при выполнении команды.
```c
void ExecuteCmd(int index){
  // Сommand execution function prototype
  switch(index){
    default:
    break;
  }
}
```
7. Прототип спец. функции. Например сохранение параметра в EEPROM.
```c
void SpecFunction(int index){
  // special function prototype
  switch(index){
    case 0: // Menu0

    break; // end of Menu0
    case 2: // Menu4

    break; // end of Menu4
    case 3: // Menu5

    break; // end of Menu5
    case 4: // Menu2

    break; // end of Menu2
    case 5: // Menu3

    break; // end of Menu3
    default:
    break;
  }
}
```
