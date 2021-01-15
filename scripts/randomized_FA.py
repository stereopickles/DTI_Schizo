#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jan 15 10:51:16 2021

@author: Eunjoo Byeon

A script to copy over existing files and rename them to 
new numbers and generate a key reference of old-new name match

"""


def find_files(dir, fpath):
    ''' find the name of file in the directory ''' 
    pass

def copy_files(fpath, new_path): 
    ''' copy over a file to the new path '''
    pass

def random_assignment(fpath):
    ''' 
    extract the current subject number, 
    assign a new number, 
    return a dictionary of old/new
    '''
    pass

def rename_files(fpath, old_name, new_name):
    pass


def rand_assignment_processing():
    '''
    take a directory then rename all files 
    and return the dictionary of old-new file name references
    '''
    ref = random_assignment(fpath)
    for old, new in ref: 
        rename_files(fpath, old, new)
    
    return ref
