/****************************************************************************
** Meta object code from reading C++ file 'look_at_point_tool.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.8)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../src/spot_ros/spot_viz/src/look_at_point_tool.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'look_at_point_tool.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.8. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_spot_viz__LookAtPointTool_t {
    QByteArrayData data[1];
    char stringdata0[26];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_spot_viz__LookAtPointTool_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_spot_viz__LookAtPointTool_t qt_meta_stringdata_spot_viz__LookAtPointTool = {
    {
QT_MOC_LITERAL(0, 0, 25) // "spot_viz::LookAtPointTool"

    },
    "spot_viz::LookAtPointTool"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_spot_viz__LookAtPointTool[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       0,    0, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

       0        // eod
};

void spot_viz::LookAtPointTool::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    Q_UNUSED(_o);
    Q_UNUSED(_id);
    Q_UNUSED(_c);
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject spot_viz::LookAtPointTool::staticMetaObject = { {
    &rviz::FocusTool::staticMetaObject,
    qt_meta_stringdata_spot_viz__LookAtPointTool.data,
    qt_meta_data_spot_viz__LookAtPointTool,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *spot_viz::LookAtPointTool::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *spot_viz::LookAtPointTool::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_spot_viz__LookAtPointTool.stringdata0))
        return static_cast<void*>(this);
    return rviz::FocusTool::qt_metacast(_clname);
}

int spot_viz::LookAtPointTool::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = rviz::FocusTool::qt_metacall(_c, _id, _a);
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
