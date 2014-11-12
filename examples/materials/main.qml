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

import Qt3D 2.0
import Qt3D.Render 2.0
import QtQuick 2.1 as QQ2

Entity {
    id: root
    objectName: "root"

    // Use the renderer configuration specified in ForwardRenderer.qml
    // and render from the mainCamera
    components: [
        FrameGraph {
            activeFrameGraph: ForwardRenderer {
                id: renderer
                camera: mainCamera
            }
        }
    ]

    BasicCamera {
        id: mainCamera
        position: Qt.vector3d( 0.0, 3.5, 25.0 )
        viewCenter: Qt.vector3d( 0.0, 3.5, 0.0 )
    }

    Configuration  {
        controlledCamera: mainCamera
    }

    AdsEffect {
        id: adsEffect
    }

    DiffuseMapEffect {
        id: diffuseMapEffect
    }

    DiffuseSpecularMapEffect {
        id: diffuseSpecularMapEffect
    }

    NormalDiffuseSpecularMapEffect {
        id: normalDiffuseSpecularMapEffect
    }

    NormalDiffuseMapEffect {
        id: normalDiffuseMapEffect
    }

    NormalDiffuseMapAlphaEffect {
        id: normalDiffuseMapAlphaEffect
    }

    AdsMaterial {
        id: redAdsMaterial
        effect: adsEffect
        ambient: Qt.rgba( 0.2, 0.0, 0.0, 1.0 )
        diffuse: Qt.rgba( 0.8, 0.0, 0.0, 1.0 )
    }

    PlaneEntity {
        id: floor

        width: 100
        height: 100
        resolution: Qt.size(20, 20)

        material: NormalDiffuseSpecularMapMaterial {
            id: mat
            effect: normalDiffuseSpecularMapEffect
            ambient: Qt.rgba( 0.2, 0.2, 0.2, 1.0 )
            diffuse:  "assets/textures/pattern_09/diffuse.webp"
            specular: "assets/textures/pattern_09/specular.webp"
            normal:   "assets/textures/pattern_09/normal.webp"
            textureScale: 10.0
            shininess: 80.0
        }
    }

    TrefoilKnot {
        id: trefoilKnot
        material: redAdsMaterial
        y: 3.5
        scale: 0.5

        QQ2.ParallelAnimation {
            loops: QQ2.Animation.Infinite
            running: true

            QQ2.NumberAnimation {
                target: trefoilKnot
                property: "theta"
                from: 0; to: 360
                duration: 2000
            }

            QQ2.NumberAnimation {
                target: trefoilKnot
                property: "phi"
                from: 0; to: 360
                duration: 2000
            }
        }
    }

    Chest {
        x: -8
        diffuseMapEffect: diffuseMapEffect
    }

    HousePlant {
        x: 4
        normalDiffuseMapEffect: normalDiffuseMapEffect
        normalDiffuseMapAlphaEffect: normalDiffuseMapAlphaEffect
        potShape: "square"
        plantType: "bamboo"
    }

    HousePlant {
        z: 4
        normalDiffuseMapEffect: normalDiffuseMapEffect
        normalDiffuseMapAlphaEffect: normalDiffuseMapAlphaEffect
        potShape: "triangle"
        plantType: "palm"
    }

    HousePlant {
        x: -4
        normalDiffuseMapEffect: normalDiffuseMapEffect
        normalDiffuseMapAlphaEffect: normalDiffuseMapAlphaEffect
        potShape: "sphere"
        plantType: "pine"
    }

    HousePlant {
        z: -4
        normalDiffuseMapEffect: normalDiffuseMapEffect
        normalDiffuseMapAlphaEffect: normalDiffuseMapAlphaEffect
        potShape: "cross"
        plantType: "spikes"
    }

    HousePlant {
        z: -8
        normalDiffuseMapEffect: normalDiffuseMapEffect
        normalDiffuseMapAlphaEffect: normalDiffuseMapAlphaEffect
        potShape: "cross"
        plantType: "palm"
        scale: 0.05
    }

    HousePlant {
        z: 8
        normalDiffuseMapEffect: normalDiffuseMapEffect
        normalDiffuseMapAlphaEffect: normalDiffuseMapAlphaEffect
        potShape: "cross"
        plantType: "shrub"
        scale: 0.05
    }

    Barrel {
        x: 8
        normalDiffuseSpecularMapEffect: normalDiffuseSpecularMapEffect
    }

    Barrel {
        x: 10
        normalDiffuseSpecularMapEffect: normalDiffuseSpecularMapEffect
        diffuseColor: "rust"
        bump: "hard_bumps"
        specular: "rust"
    }

    Barrel {
        x: 12
        normalDiffuseSpecularMapEffect: normalDiffuseSpecularMapEffect
        diffuseColor: "blue"
        bump: "middle_bumps"
    }

    Barrel {
        x: 14
        normalDiffuseSpecularMapEffect: normalDiffuseSpecularMapEffect
        diffuseColor: "green"
        bump: "soft_bumps"
    }

    Barrel {
        x: 16
        normalDiffuseSpecularMapEffect: normalDiffuseSpecularMapEffect
        diffuseColor: "stainless_steel"
        bump: "no_bumps"
        specular: "stainless_steel"
        shininess: 150
    }
}
