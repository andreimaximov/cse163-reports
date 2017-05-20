#version 330 core

layout (location = 0) in vec3 position;
layout (location = 1) in vec3 normals;

out vec4 vertexColor;

uniform mat4 transform;
uniform mat4 view;
uniform mat4 projection;

void main() {
  gl_Position = projection * view * transform * vec4(position, 1.0);
  vertexColor = vec4((normals + 1) * 0.5, 1.0);
}