/****************************************************************************
**
** Copyright (C) 2014 Klaralvdalens Datakonsult AB (KDAB).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt3D module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia.  For licensing terms and
** conditions see http://qt.digia.com/licensing.  For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights.  These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3.0 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU General Public License version 3.0 requirements will be
** met: http://www.gnu.org/copyleft/gpl.html.
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include "parameter.h"
#include "renderlogging.h"

QT_BEGIN_NAMESPACE

namespace Qt3D {

Parameter::Parameter(QObject *parent, QString name, int ty) :
    QObject(parent),
    m_name(name),
    m_type(ty),
    m_standardUniform(None)
{

}

void Parameter::setName(const QString &name)
{
    if (m_name != name) {
        m_name = name;
        emit nameChanged();
    }
}

void Parameter::setMeshAttributeName(QString name)
{
    if (m_meshName != name) {
        m_meshName = name;
        emit meshAttributeNameChanged();
    }
}

bool Parameter::isStandardUniform() const
{
    return (m_standardUniform != None);
}

void Parameter::setStandardUniform(Parameter::StandardUniform su)
{
    m_standardUniform = su;
}

Parameter::StandardUniform Parameter::standardUniform() const
{
    return m_standardUniform;
}

void Parameter::setDatatype(int type)
{
    if (m_type != type) {
        m_type = type;
        emit datatypeChanged();
    }
}

bool Parameter::isTextureType() const
{
    switch (m_type) {
    case GL_SAMPLER_1D:
    case GL_SAMPLER_2D:
    case GL_SAMPLER_3D:
    case GL_SAMPLER_CUBE:
        return true;
    default:
        return false;
    }
}

Render::QUniformValue::Type Parameter::uniformType() const
{
    switch (m_type) {
    case GL_BOOL:
    case GL_BOOL_VEC2:
    case GL_BOOL_VEC3:
    case GL_BOOL_VEC4:
        return Render::QUniformValue::Bool;

    // integers!

    case GL_FLOAT:
    case GL_FLOAT_VEC2:
    case GL_FLOAT_VEC3:
    case GL_FLOAT_VEC4:
    case GL_FLOAT_MAT4:
        return Render::QUniformValue::Float;

    case GL_DOUBLE:
#ifdef GL_DOUBLE_VEC3 // Required to compile on pre GL 4.1 systems
    case GL_DOUBLE_VEC2:
    case GL_DOUBLE_VEC3:
    case GL_DOUBLE_VEC4:
#endif
        return Render::QUniformValue::Double;

    default:
        qCWarning(Render::Backend) << Q_FUNC_INFO << "couldn't map datatype:" << QString::number(m_type, 16);
        return Render::QUniformValue::Invalid;
    }
}

} // Qt3D

QT_END_NAMESPACE