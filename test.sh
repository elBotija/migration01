#!/bin/bash

# Create test branches
create_branch() {
    local branch_name=$1
    local variable_value=$2
    
    git checkout -b $branch_name
    echo "export MIVARIABLE=\"$variable_value\"" > .github_execute_vars
    git add .github_execute_vars
    git commit -m "feat: Add .github_execute_vars for branch $branch_name"
    git checkout main
}

# Create test tags
create_tag() {
    local tag_name=$1
    local branch_name=$2
    local variable_value=$3
    
    git checkout -b temp_$branch_name
    echo "export MIVARIABLE=\"$variable_value\"" > .github_execute_vars
    git add .github_execute_vars
    git commit -m "feat: Add .github_execute_vars for tag $tag_name"
    git tag -a $tag_name -m "Creating test tag $tag_name"
    git checkout main
    git branch -D temp_$branch_name
}

# Create initial main branch setup
echo "export MIVARIABLE=\"main-value\"" > .github_execute_vars
git add .github_execute_vars
git commit -m "feat: Initial .github_execute_vars setup"

# Create branches
create_branch "feature/test1" "feature1-value"
create_branch "feature/test2" "feature2-value"
create_branch "feature/test3" "feature3-value"

# Create tags
create_tag "v1.0.0" "release1" "tag1-value"
create_tag "v1.1.0" "release2" "tag2-value"
create_tag "v1.2.0" "release3" "tag3-value"
create_tag "v2.0.0" "release4" "tag4-value"
create_tag "v2.1.0" "release5" "tag5-value"

echo "Setup completed! Created:"
echo "Branches:"
git branch -a | grep "feature"
echo "Tags:"
git tag -l
